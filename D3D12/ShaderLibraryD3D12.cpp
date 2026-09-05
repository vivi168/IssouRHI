#include "ShaderLibraryD3D12.h"

#include "DeviceD3D12.h"

namespace IssouRHI
{
namespace D3D12
{
ShaderLibraryImpl::ShaderLibraryImpl(Device* device) : ShaderLibrary(device) {}

ShaderLibraryImpl::~ShaderLibraryImpl() = default;

void ShaderLibraryImpl::Create(std::span<std::byte> code)
{
  m_Library.pShaderBytecode = code.data();
  m_Library.BytecodeLength = code.size();
}
}  // namespace D3D12
}  // namespace IssouRHI
