#pragma once

#include "CommonMTL.h"

namespace IssouRHI
{
namespace MTL
{
class TextureImpl : public Texture
{
public:
  TextureImpl(Device* device, const TextureDesc& desc, bool frameBufferOnly = false);
  ~TextureImpl() override;

  void Create() override;

  void Write(std::span<TextureSubresource> subresources, uint32_t baseMipLevel = 0, uint32_t baseArrayLayer = 0) override;

  std::shared_ptr<TextureView> CreateView(const TextureViewDesc& desc) override;

public:
  void Wrap(id<MTLTexture> textureView);

private:
  id<MTLTexture> m_Texture;

  bool m_FrameBufferOnly = false;
};

inline TextureImpl* ToBackend(Texture* tex) { return static_cast<TextureImpl*>(tex); }

class TextureViewImpl : public TextureView
{
public:
  TextureViewImpl(Texture* tex, const TextureViewDesc& desc);
  ~TextureViewImpl() override;

  uint32_t DescriptorIndex(TextureAccess) const override { return 0; }

  uint64_t DescriptorHandle(TextureAccess) const override { return 0; }

public:
  id<MTLTexture> GetNativeTextureView() const { return m_TextureView; }

  void Wrap(id<MTLTexture> texture);

private:
  id<MTLTexture> m_TextureView;
};

inline TextureViewImpl* ToBackend(TextureView* tv) { return static_cast<TextureViewImpl*>(tv); }
}  // namespace MTL
}  // namespace IssouRHI
