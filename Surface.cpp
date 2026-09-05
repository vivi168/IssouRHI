#include "IssouRHI.h"

namespace IssouRHI
{
Surface::Surface(Device* device, void* handle) : m_Device(device), m_Handle(handle), m_Config({}) {}

Surface::~Surface() = default;
}  // namespace IssouRHI
