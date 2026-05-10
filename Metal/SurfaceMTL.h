#pragma once

#include "CommonMTL.h"

namespace IssouRHI
{
namespace MTL
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
  CAMetalLayer* m_Layer = nil;
  id<CAMetalDrawable> m_Drawable;
};
}  // namespace MTL
}  // namespace IssouRHI
