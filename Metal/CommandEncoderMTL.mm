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
  // TODO
  return nullptr;
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

void RenderPassEncoderImpl::Draw(uint32_t vertexCount, uint32_t instanceCount, uint32_t firstVertex, uint32_t firstInstance)
{
  // TODO
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

  m_Ended = true;
}

void RenderPassEncoderImpl::PushConstants(uint32_t offset, uint32_t size, const void* data)
{
  // TODO
}

void RenderPassEncoderImpl::SetPipeline(RenderPipeline* pipeline)
{
  // TODO
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
}
}
