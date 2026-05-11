#include "TextureMTL.h"

#include "DeviceMTL.h"
#include "UtilsMTL.h"

namespace IssouRHI
{
namespace MTL
{
TextureImpl::TextureImpl(Device* device, const TextureDesc& desc, bool frameBufferOnly) : Texture(device, desc), m_FrameBufferOnly(frameBufferOnly) {}

TextureImpl::~TextureImpl() = default;

void TextureImpl::Create()
{
  // TODO
}

void TextureImpl::Write(std::span<TextureSubresource> subresources, uint32_t baseMipLevel, uint32_t baseArrayLayer)
{
  // TODO
}

static MTLTextureType ToMTLTextureType(TextureViewDimension dim)
{
  switch (dim) {
    case TextureViewDimension::Texture1D:
      return MTLTextureType1D;
    case TextureViewDimension::Texture2D:
      return MTLTextureType2D;
    case TextureViewDimension::Texture2DAry:
      return MTLTextureType2DArray;
    case TextureViewDimension::TextureCube:
      return MTLTextureTypeCube;
    case TextureViewDimension::TextureCubeAry:
      return MTLTextureTypeCubeArray;
    case TextureViewDimension::Texture3D:
      return MTLTextureType3D;
  }
}

static MTLTextureViewDescriptor* ToMTLTextureViewDescriptor(const TextureViewDesc& desc)
{
  MTLTextureViewDescriptor* outDesc = [[MTLTextureViewDescriptor alloc] init];

  outDesc.pixelFormat = ToMTLPixelFormat(desc.format);
  outDesc.textureType = ToMTLTextureType(desc.dimension);
  outDesc.levelRange = NSMakeRange(desc.range.baseMipLevel, desc.range.mipLevelCount);
  outDesc.sliceRange = NSMakeRange(desc.range.baseArrayLayer, desc.range.arrayLayerCount);

  // outDesc.swizzle

  return outDesc;
}

std::shared_ptr<TextureView> TextureImpl::CreateView(const TextureViewDesc& desc)
{
  if (auto it = m_Views.find(desc); it != m_Views.end()) {
    return it->second;
  }

  auto view = std::make_shared<TextureViewImpl>(this, desc);

  if (m_FrameBufferOnly) {
    view->Wrap(m_Texture);
  } else {
    MTLTextureViewDescriptor* viewDesc = ToMTLTextureViewDescriptor(desc);
    id<MTLTexture> textureView = [m_Texture newTextureViewWithDescriptor:viewDesc];
    view->Wrap(textureView);
  }

  m_Views[desc] = view;

  return view;
}

void TextureImpl::Wrap(id<MTLTexture> texture)
{
  m_Texture = texture;
}

TextureViewImpl::TextureViewImpl(Texture* tex, const TextureViewDesc& desc) : TextureView(tex, desc) {}

TextureViewImpl::~TextureViewImpl() = default;

void TextureViewImpl::Wrap(id<MTLTexture> textureView)
{
  m_TextureView = textureView;
}
}  // namespace MTL
}  // namespace IssouRHI
