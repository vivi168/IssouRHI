#include "IssouRHI.h"

#include <cmath>

namespace IssouRHI
{
Sampler::Sampler(Device* device, const SamplerDesc& desc) : m_Device(device), m_Desc(desc) {}

Sampler::~Sampler() = default;
}  // namespace IssouRHI
