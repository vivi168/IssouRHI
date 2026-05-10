#pragma once

#include "CommonMTL.h"

namespace IssouRHI
{
namespace MTL
{
class DeviceImpl : public Device {
public:
  DeviceImpl(const GPUSelection& gpuSelection);
  ~DeviceImpl() override;

  void Create(const GPUSelection& gpuSelection) override;

  void PrintAdapterInformation() override;

  std::shared_ptr<Surface> CreateSurface(void* handle) override;
  std::shared_ptr<QuerySet> CreateQuerySet(const QuerySetDesc& desc) override;
  std::shared_ptr<Texture> CreateTexture(const TextureDesc& desc) override;
  std::shared_ptr<Buffer> CreateBuffer(const BufferDesc& desc) override;
  std::shared_ptr<AccelerationStructure> CreateAccelerationStructure(const AccelerationStructureDesc& desc) override;

  std::shared_ptr<ComputePipeline> CreateComputePipeline(const ComputePipelineDesc& desc) override;
  std::shared_ptr<RenderPipeline> CreateRenderPipeline(const RenderPipelineDesc& desc) override;
  std::shared_ptr<RenderPipeline> CreateMeshPipeline(const RenderPipelineDesc& desc) override;
  std::shared_ptr<RayTracingPipeline> CreateRayTracingPipelinePipeline(const RayTracingPipelineDesc& desc) override;
  std::shared_ptr<ShaderTable> CreateShaderTable(const ShaderTableDesc& desc) override;

public:
  id<MTLDevice> GetNativeDevice() const { return m_Device; }

private:
  id<MTLDevice> m_Device;
};

inline DeviceImpl* ToBackend(Device* device) { return static_cast<DeviceImpl*>(device); }
}
}
