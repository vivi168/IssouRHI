#include "CommandEncoderMTL.h"

#include "AccelerationStructureMTL.h"
#include "BufferMTL.h"
#include "DeviceMTL.h"
#include "PipelineMTL.h"
#include "QuerySetMTL.h"
#include "ShaderTableMTL.h"
#include "TextureMTL.h"
#include "UtilsMTL.h"

namespace IssouRHI
{
namespace MTL
{
CommandEncoderImpl::CommandEncoderImpl(std::string label, CommandBuffer* commandBuffer) : CommandEncoder(label, commandBuffer) {}

CommandEncoderImpl::~CommandEncoderImpl() = default;

std::unique_ptr<ComputePassEncoder> CommandEncoderImpl::BeginComputePass(const ComputePassDesc& desc)
{
  // TODO
  return nullptr;
}

std::unique_ptr<RenderPassEncoder> CommandEncoderImpl::BeginRenderPass(const RenderPassDesc& desc)
{
  if (desc.timestampWrites.has_value()) {
    // TODO
  }

  MTL4RenderPassDescriptor* pass_desc = [[MTL4RenderPassDescriptor alloc] init];

  for (size_t i = 0; i < desc.colorAttachment.size(); i++) {
    const auto& colorAttachment = desc.colorAttachment[i];
    MTLRenderPassColorAttachmentDescriptor* colorAttachmentDesc = pass_desc.colorAttachments[i];

    colorAttachmentDesc.texture = ToBackend(colorAttachment.view)->GetNativeTextureView();
    colorAttachmentDesc.slice = colorAttachment.depthSlice;

    // TODO: function
    const auto& c = colorAttachment.clearValue;
    colorAttachmentDesc.clearColor = MTLClearColorMake(c.r, c.g, c.b, c.a);

    // TODO: function
    switch (colorAttachment.loadOp) {
      case LoadOp::Clear:
        colorAttachmentDesc.loadAction = MTLLoadActionClear;
        break;
      case LoadOp::Load:
        colorAttachmentDesc.loadAction = MTLLoadActionLoad;
        break;
      case LoadOp::DontCare:
        colorAttachmentDesc.loadAction = MTLLoadActionDontCare;
        break;
    }

    // TODO: function
    switch (colorAttachment.storeOp) {
      case StoreOp::Store:
        colorAttachmentDesc.storeAction = MTLStoreActionStore;
        break;
      case StoreOp::Discard:
        colorAttachmentDesc.storeAction = MTLStoreActionDontCare;
        break;
    }

    if (colorAttachment.resolveTarget) {
      colorAttachmentDesc.resolveTexture = ToBackend(colorAttachment.resolveTarget)->GetNativeTextureView();
      colorAttachmentDesc.storeAction = MTLStoreActionMultisampleResolve;
    }
  }

  // TODO: DepthStencilAttachment

  auto cmdBuffer = ToBackend(m_CommandBuffer)->GetNativeCommandBuffer();
  id<MTL4RenderCommandEncoder> cmdEncoder = [cmdBuffer renderCommandEncoderWithDescriptor:pass_desc];

  auto passEncoder = std::make_unique<RenderPassEncoderImpl>(desc, m_CommandBuffer);
  passEncoder->Wrap(cmdEncoder);

  return passEncoder;
}

std::unique_ptr<RayTracingPassEncoder> CommandEncoderImpl::BeginRayTracingPass(const RayTracingPassDesc& desc)
{
  // TODO
  return nullptr;
}

void CommandEncoderImpl::Barrier(const BarriersDesc&)
{
  // noop
  return;
}

void CommandEncoderImpl::BuildTopLevelAccelerationStructure(AccelerationStructure* dst, BufferWithOffset instances, uint32_t instanceCount, AccelerationStructure* src)
{
  // TODO
}

void CommandEncoderImpl::BuildBottomLevelAccelerationStructure(AccelerationStructure* dst, std::span<BottomLevelGeometryDesc> geometries, AccelerationStructure* src)
{
  // TODO
}

void CommandEncoderImpl::CopyBufferToBuffer(Buffer* src, uint64_t srcOffset, Buffer* dst, uint64_t dstOffset, uint64_t size)
{
  // TODO
}

void CommandEncoderImpl::ResolveQuerySet(QuerySet* querySet, uint32_t firstQuery, uint32_t queryCount, Buffer* dst, uint64_t dstOffset)
{
  // TODO
}

void CommandEncoderImpl::WriteTimestamp(QuerySet* querySet, uint32_t index)
{
  // TODO
}

CommandBuffer* CommandEncoderImpl::Finish()
{
  [ToBackend(m_CommandBuffer)->GetNativeCommandBuffer() endCommandBuffer];
  CommandBuffer* ptr = m_CommandBuffer;
  m_CommandBuffer = nullptr;
  return ptr;
}

ComputePassEncoderImpl::ComputePassEncoderImpl(const ComputePassDesc& desc, CommandBuffer* commandBuffer) : ComputePassEncoder(desc, commandBuffer) {}

ComputePassEncoderImpl::~ComputePassEncoderImpl() = default;

void ComputePassEncoderImpl::Dispatch(uint32_t x, uint32_t y, uint32_t z)
{
  // TODO
}

void ComputePassEncoderImpl::End()
{
  if (m_Desc.timestampWrites.has_value()) {
    // TODO
  }

  m_Ended = true;
}

void ComputePassEncoderImpl::PushConstants(uint32_t offset, uint32_t size, const void* data)
{
  // TODO
}

void ComputePassEncoderImpl::SetPipeline(ComputePipeline* pipeline)
{
  // TODO
}

RenderPassEncoderImpl::RenderPassEncoderImpl(const RenderPassDesc& desc, CommandBuffer* commandBuffer) : RenderPassEncoder(desc, commandBuffer) {}

RenderPassEncoderImpl::~RenderPassEncoderImpl() = default;

void RenderPassEncoderImpl::Wrap(id<MTL4RenderCommandEncoder> encoder)
{
  m_Encoder = encoder;
}

void RenderPassEncoderImpl::Draw(uint32_t vertexCount, uint32_t instanceCount, uint32_t firstVertex, uint32_t firstInstance)
{
  [m_Encoder drawPrimitives:MTLPrimitiveTypeTriangle
                vertexStart:firstVertex
                vertexCount:vertexCount
              instanceCount:instanceCount
               baseInstance:firstInstance];
}

void RenderPassEncoderImpl::DrawMeshIndirect(Buffer* indirectBuffer, uint64_t indirectOffset, uint32_t maxDrawCount, Buffer* countBuffer, uint64_t countOffset)
{
  // TODO
}

void RenderPassEncoderImpl::End()
{
  // TODO: mark encoder as open = false
  // TODO: ResolveSubresource if MSAA (resolveTarget)

  if (m_Desc.timestampWrites.has_value()) {
    // TODO
  }

  [m_Encoder endEncoding];

  m_Ended = true;
}

void RenderPassEncoderImpl::PushConstants(uint32_t offset, uint32_t size, const void* data)
{
  // TODO
}

void RenderPassEncoderImpl::SetPipeline(RenderPipeline* pipeline)
{
  [m_Encoder setRenderPipelineState:ToBackend(pipeline)->PipelineState()];
}

RayTracingPassEncoderImpl::RayTracingPassEncoderImpl(const RayTracingPassDesc& desc, CommandBuffer* commandBuffer) : RayTracingPassEncoder(desc, commandBuffer) {}

RayTracingPassEncoderImpl::~RayTracingPassEncoderImpl() = default;

void RayTracingPassEncoderImpl::End()
{
  if (m_Desc.timestampWrites.has_value()) {
    // TODO
  }

  m_Ended = true;
}

void RayTracingPassEncoderImpl::PushConstants(uint32_t offset, uint32_t size, const void* data)
{
  // TODO
}

void RayTracingPassEncoderImpl::SetPipeline(RayTracingPipeline* pipeline)
{
  // TODO
}

void RayTracingPassEncoderImpl::TraceRays(ShaderTable* shaderTable, uint32_t width, uint32_t height, uint32_t depth)
{
  // TODO
}
}  // namespace MTL
}  // namespace IssouRHI
