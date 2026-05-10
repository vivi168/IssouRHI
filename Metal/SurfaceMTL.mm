#include "SurfaceMTL.h"

#include "DeviceMTL.h"
#include "QueueMTL.h"
#include "TextureMTL.h"
#include "UtilsMTL.h"

#import <AppKit/AppKit.h>

namespace IssouRHI
{
namespace MTL
{
SurfaceImpl::SurfaceImpl(Device* device, void* handle) : Surface(device, handle) {}

SurfaceImpl::~SurfaceImpl() = default;

void SurfaceImpl::Create()
{
  m_Layer = [CAMetalLayer layer];
  m_Layer.device = ToBackend(m_Device)->GetNativeDevice();

  NSWindow* nswin = (__bridge NSWindow*)m_Handle;
  nswin.contentView.wantsLayer = YES;
  nswin.contentView.layer = m_Layer;
}

void SurfaceImpl::Configure(SurfaceConfiguration& config)
{
  // FIXME: allow reconfiguration/window resize
  if (m_Configured) return;

  m_Layer.pixelFormat = ToMTLPixelFormat(config.format);
  m_Layer.maximumDrawableCount = config.bufferCount;
  m_Layer.drawableSize = CGSizeMake(config.width, config.height);
  m_Layer.displaySyncEnabled = config.enableVsync;

  m_Configured = true;
  m_Config = config;
}

std::shared_ptr<Texture> SurfaceImpl::GetCurrentTexture()
{
  @autoreleasepool {
    m_Drawable = [m_Layer nextDrawable];

    if (!m_Drawable) {
      return nullptr;
    }

    auto cmdQueue = ToBackend(m_Device->GetQueue())->GetNativeQueue();
    [cmdQueue waitForDrawable:m_Drawable];

    TextureDesc desc{};
    desc.size = {
        .width = m_Config.width,
        .height = m_Config.height,
    };
    desc.format = m_Config.format;
    desc.usage = TextureUsage::RenderAttachment;

    auto tex = std::make_shared<TextureImpl>(m_Device, desc);
    tex->Wrap([m_Drawable texture]);

    return tex;
  }
};

void SurfaceImpl::Present()
{
  assert(m_Drawable);

  auto cmdQueue = ToBackend(m_Device->GetQueue())->GetNativeQueue();

  assert(cmdQueue);

  [cmdQueue signalDrawable:m_Drawable];
  [m_Drawable present];

  m_Drawable = nil;
};
}
}
