#include "DeviceMTL.h"

#include "CreateDeviceMTL.h"

#include "AccelerationStructureMTL.h"
#include "BufferMTL.h"
#include "PipelineMTL.h"
#include "QuerySetMTL.h"
#include "QueueMTL.h"
#include "ShaderTableMTL.h"
#include "SurfaceMTL.h"
#include "TextureMTL.h"
#include "UtilsMTL.h"

namespace IssouRHI
{
namespace MTL
{
std::unique_ptr<Device> CreateDeviceImpl(const GPUSelection& gpuSelection)
{
  return std::make_unique<MTL::DeviceImpl>(gpuSelection);
}

DeviceImpl::DeviceImpl(const GPUSelection& gpuSelection)
{
  Create(gpuSelection);
}

DeviceImpl::~DeviceImpl() = default;

void DeviceImpl::Create(const GPUSelection&)
{
  // TODO: from GPUSelection instead of system default?
  m_Device = MTLCreateSystemDefaultDevice();

  // Create Command Queue
  {
    m_Queue = std::make_unique<QueueImpl>(this);
    m_Queue->Create();
  }
}

void DeviceImpl::PrintAdapterInformation() {}

std::shared_ptr<Surface> DeviceImpl::CreateSurface(void* handle)
{
  auto surf = std::make_shared<SurfaceImpl>(this, handle);
  surf->Create();

  return surf;
  return nullptr;
}

std::shared_ptr<QuerySet> DeviceImpl::CreateQuerySet(const QuerySetDesc& desc)
{
  // TODO
  return nullptr;
}

std::shared_ptr<Texture> DeviceImpl::CreateTexture(const TextureDesc& desc)
{
  // TODO
  return nullptr;
}

std::shared_ptr<Buffer> DeviceImpl::CreateBuffer(const BufferDesc& desc)
{
  // TODO
  return nullptr;
}

std::shared_ptr<AccelerationStructure> DeviceImpl::CreateAccelerationStructure(const AccelerationStructureDesc& desc)
{
  // TODO
  return nullptr;
}


std::shared_ptr<ComputePipeline> DeviceImpl::CreateComputePipeline(const ComputePipelineDesc& desc)
{
  // TODO
  return nullptr;
}

std::shared_ptr<RenderPipeline> DeviceImpl::CreateRenderPipeline(const RenderPipelineDesc& desc)
{
  // TODO
  return nullptr;
}

std::shared_ptr<RenderPipeline> DeviceImpl::CreateMeshPipeline(const RenderPipelineDesc& desc)
{
  // TODO
  return nullptr;
}

std::shared_ptr<RayTracingPipeline> DeviceImpl::CreateRayTracingPipelinePipeline(const RayTracingPipelineDesc& desc)
{
  // TODO
  return nullptr;
}

std::shared_ptr<ShaderTable> DeviceImpl::CreateShaderTable(const ShaderTableDesc& desc)
{
  // TODO
  return nullptr;
}

}
}
