#pragma once

#include "CommonMTL.h"

namespace IssouRHI
{
namespace MTL
{
class ComputePipelineImpl : public ComputePipeline
{
public:
  ComputePipelineImpl(Device* device);
  ~ComputePipelineImpl() override;

  void Create(const ComputePipelineDesc& desc) override;

public:
  id<MTLComputePipelineState> PipelineState() const { return m_Pso; }

private:
  id<MTLComputePipelineState> m_Pso;
};

inline ComputePipelineImpl* ToBackend(ComputePipeline* pipeline) { return static_cast<ComputePipelineImpl*>(pipeline); }

inline const ComputePipelineImpl* ToBackend(const ComputePipeline* pipeline) { return static_cast<const ComputePipelineImpl*>(pipeline); }

class RenderPipelineImpl : public RenderPipeline
{
public:
  RenderPipelineImpl(Device* device, Type type);
  ~RenderPipelineImpl() override;

  void Create(const RenderPipelineDesc& desc) override;

public:
  id<MTLRenderPipelineState> PipelineState() const { return m_Pso; }

  // TODO: equivalent of D3D12_PRIMITIVE_TOPOLOGY NativePrimitiveTopology() const { return m_PrimitiveTopology; }

private:
  id<MTLRenderPipelineState> m_Pso;

  // TODO: equivalent of D3D12_PRIMITIVE_TOPOLOGY m_PrimitiveTopology = D3D_PRIMITIVE_TOPOLOGY_UNDEFINED;
};

inline RenderPipelineImpl* ToBackend(RenderPipeline* pipeline) { return static_cast<RenderPipelineImpl*>(pipeline); }

inline const RenderPipelineImpl* ToBackend(const RenderPipeline* pipeline) { return static_cast<const RenderPipelineImpl*>(pipeline); }

class RayTracingPipelineImpl : public RayTracingPipeline
{
};
}  // namespace MTL
}  // namespace IssouRHI
