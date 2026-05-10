#pragma once

#include "CommonMTL.h"

namespace IssouRHI
{
namespace MTL
{
inline MTLPixelFormat ToMTLPixelFormat(TextureFormat format)
{
  switch (format) {
    case TextureFormat::Undefined:
      return MTLPixelFormatInvalid;
    case TextureFormat::BC5Unorm:
      return MTLPixelFormatBC5_RGUnorm;
    case TextureFormat::BC7Unorm:
      return MTLPixelFormatBC7_RGBAUnorm;
    case TextureFormat::BGRA8Unorm:
      return MTLPixelFormatBGRA8Unorm;
    case TextureFormat::BGRA8Unorm_sRGB:
      return MTLPixelFormatBGRA8Unorm_sRGB;
    case TextureFormat::Depth32Float:
      return MTLPixelFormatDepth32Float;
    case TextureFormat::R8Unorm:
      return MTLPixelFormatR8Unorm;
    case TextureFormat::RG8Unorm:
      return MTLPixelFormatRG8Unorm;
    case TextureFormat::R32Uint:
      return MTLPixelFormatR32Uint;
    case TextureFormat::RGBA8Unorm:
      return MTLPixelFormatRGBA8Unorm;
    case TextureFormat::RGB10A2Unorm:
      return MTLPixelFormatRGB10A2Unorm;
    case TextureFormat::RGBA32Float:
      return MTLPixelFormatRGBA32Float;
    default:
      std::unreachable();
  }
}
}
}
