#include <IssouRHI.h>

namespace IssouRHI
{
ShaderLibrary::ShaderLibrary(Device* device) : m_Device(device) {}

ShaderLibrary::~ShaderLibrary() = default;
}  // namespace IssouRHI
