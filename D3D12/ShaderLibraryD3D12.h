#pragma once

#include "CommonD3D12.h"

namespace IssouRHI
{
namespace D3D12
{
class ShaderLibraryImpl : public ShaderLibrary
{
public:
  ShaderLibraryImpl(Device* device);
  ~ShaderLibraryImpl() override;

  void Create(std::span<std::byte> code) override;

public:
  D3D12_SHADER_BYTECODE GetNativeLibrary() const { return m_Library; }

private:
  D3D12_SHADER_BYTECODE m_Library;
};

inline ShaderLibraryImpl* ToBackend(ShaderLibrary* lib) { return static_cast<ShaderLibraryImpl*>(lib); }
}  // namespace D3D12
}  // namespace IssouRHI
