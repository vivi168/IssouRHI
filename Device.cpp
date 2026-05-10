#include "IssouRHI.h"

#ifdef BUILD_D3D12_BACKEND
#include "D3D12/DeviceD3D12.h"
#endif
#ifdef BUILD_METAL_BACKEND
#include "Metal/CreateDeviceMTL.h"
#endif

namespace IssouRHI
{
std::unique_ptr<Device> Device::CreateDevice(Backend backend, const GPUSelection& gpuSelection)
{
  switch (backend) {
    case Backend::D3D12:
#ifdef BUILD_D3D12_BACKEND
      return std::make_unique<D3D12::DeviceImpl>(gpuSelection);
#else
      assert(false);
#endif
    case Backend::Metal:
#ifdef BUILD_METAL_BACKEND
      return MTL::CreateDeviceImpl(gpuSelection);
#else
      assert(false);
#endif
    default:
      return nullptr;
  }
}

Device::~Device() = default;
}  // namespace IssouRHI
