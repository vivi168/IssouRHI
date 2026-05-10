#pragma once

#include <IssouRHI.h>

namespace IssouRHI
{
namespace MTL
{
std::unique_ptr<Device> CreateDeviceImpl(const GPUSelection& gpuSelection);
}
}  // namespace IssouRHI
