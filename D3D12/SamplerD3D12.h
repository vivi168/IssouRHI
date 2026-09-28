#pragma once

#include "CommonD3D12.h"
#include "DescriptorHeapD3D12.h"

namespace IssouRHI
{
namespace D3D12
{
class SamplerImpl : public Sampler
{
public:
  SamplerImpl(Device* device, const SamplerDesc& desc);
  ~SamplerImpl() override;

  void Create() override;
  uint32_t DescriptorIndex() const override { return m_Allocation.index; }

private:
  DescriptorAllocation m_Allocation{};
};
}  // namespace D3D12
}  // namespace IssouRHI
