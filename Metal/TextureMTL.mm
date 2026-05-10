#include "TextureMTL.h"

#include "DeviceMTL.h"
#include "UtilsMTL.h"

namespace IssouRHI
{
namespace MTL
{
TextureImpl::TextureImpl(Device* device, const TextureDesc& desc) : Texture(device, desc) {}

TextureImpl::~TextureImpl() = default;

void TextureImpl::Create()
{
  // TODO
}

void TextureImpl::Write(std::span<TextureSubresource> subresources, uint32_t baseMipLevel, uint32_t baseArrayLayer)
{
  // TODO
}

std::shared_ptr<TextureView> TextureImpl::CreateView(const TextureViewDesc& desc)
{
  // TODO
  return nullptr;
}

void TextureImpl::Wrap(id<MTLTexture> texture)
{
  m_Texture = texture;
}

TextureViewImpl::TextureViewImpl(Texture* tex, const TextureViewDesc& desc) : TextureView(tex, desc) {}

TextureViewImpl::~TextureViewImpl() = default;

uint32_t TextureViewImpl::DescriptorIndex(TextureAccess access) const
{
  return 0;
}

uint64_t TextureViewImpl::DescriptorHandle(TextureAccess access) const
{
  return 0;
}
}  // namespace MTL
}  // namespace IssouRHI
