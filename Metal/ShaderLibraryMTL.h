#pragma once

#include "CommonMTL.h"

namespace IssouRHI
{
namespace MTL
{
class ShaderLibraryImpl : public ShaderLibrary
{
public:
  ShaderLibraryImpl(Device* device);
  ~ShaderLibraryImpl() override;

  void Create(std::span<std::byte> code) override;

public:
  id<MTLLibrary> GetNativeLibrary() const { return m_Library; }

private:
  id<MTLLibrary> m_Library;
};

inline ShaderLibraryImpl* ToBackend(ShaderLibrary* lib) { return static_cast<ShaderLibraryImpl*>(lib); }
}  // namespace MTL
}  // namespace IssouRHI
