#pragma once

#include "CommonD3D12.h"

namespace IssouRHI
{
namespace D3D12
{
class SurfaceImpl : public Surface
{
public:
  SurfaceImpl(Device* device, void* handle);
  ~SurfaceImpl() override;

  void Create() override;
  void Configure(SurfaceConfiguration& config) override;

  std::shared_ptr<Texture> GetCurrentTexture() override;
  void Present() override;

private:
  void CreateSwapChain(SurfaceConfiguration& config);
  void CreateTextures(SurfaceConfiguration& config);

  Microsoft::WRL::ComPtr<IDXGISwapChain3> m_SwapChain;
  std::vector<std::shared_ptr<Texture>> m_Textures;

  Microsoft::WRL::ComPtr<ID3D12Fence> m_Fence;
  HANDLE m_FenceEvent = nullptr;
  UINT64 m_NextFenceValue = 0;
  std::vector<UINT64> m_FenceValues;
};
}  // namespace D3D12
}  // namespace IssouRHI
