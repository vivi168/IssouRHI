#include "SamplerD3D12.h"

#include "DeviceD3D12.h"
#include "UtilsD3D12.h"

namespace IssouRHI
{
namespace D3D12
{
static D3D12_TEXTURE_ADDRESS_MODE D3D12AddressMode(AddressMode mode)
{
  switch (mode) {
    case AddressMode::ClampToEdge:
      return D3D12_TEXTURE_ADDRESS_MODE_CLAMP;
    case AddressMode::Repeat:
      return D3D12_TEXTURE_ADDRESS_MODE_WRAP;
    case AddressMode::MirrorRepeat:
      return D3D12_TEXTURE_ADDRESS_MODE_MIRROR;
    default:
      std::unreachable();
  }
}

static D3D12_FILTER_TYPE D3D12FilterType(FilterMode mode)
{
  switch (mode) {
    case FilterMode::Nearest:
      return D3D12_FILTER_TYPE_POINT;
    case FilterMode::Linear:
      return D3D12_FILTER_TYPE_LINEAR;
    default:
      std::unreachable();
  }
}

SamplerImpl::SamplerImpl(Device* device, const SamplerDesc& desc) : Sampler(device, desc) {}

SamplerImpl::~SamplerImpl()
{
  ToBackend(m_Device)->FreeSamplerDescriptor(m_Allocation);
}

void SamplerImpl::Create()
{
  const auto reduction = m_Desc.compare ? D3D12_FILTER_REDUCTION_TYPE_COMPARISON : D3D12_FILTER_REDUCTION_TYPE_STANDARD;
  const auto minFilter = D3D12FilterType(m_Desc.minFilter);
  const auto magFilter = D3D12FilterType(m_Desc.magFilter);
  const auto mipFilter = D3D12FilterType(m_Desc.mipmapFilter);

  D3D12_SAMPLER_DESC desc{};
  if (m_Desc.maxAnisotropy > 1) {
    desc.Filter = D3D12_ENCODE_ANISOTROPIC_FILTER(reduction);
  } else {
    desc.Filter = D3D12_ENCODE_BASIC_FILTER(minFilter, magFilter, mipFilter, reduction);
  }
  desc.AddressU = D3D12AddressMode(m_Desc.addressModeU);
  desc.AddressV = D3D12AddressMode(m_Desc.addressModeV);
  desc.AddressW = D3D12AddressMode(m_Desc.addressModeW);
  desc.MaxAnisotropy = m_Desc.maxAnisotropy;
  desc.ComparisonFunc = D3D12ComparisonFunc(m_Desc.compare.value_or(CompareFunction::Always));
  desc.MinLOD = m_Desc.lodMinClamp;
  desc.MaxLOD = m_Desc.lodMaxClamp;

  m_Allocation = ToBackend(m_Device)->AllocSamplerDescriptor();
  ToBackend(m_Device)->GetNativeDevice()->CreateSampler(&desc, m_Allocation.cpuHandle);
}
}  // namespace D3D12
}  // namespace IssouRHI
