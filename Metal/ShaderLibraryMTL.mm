#include "ShaderLibraryMTL.h"

#include "DeviceMTL.h"

namespace IssouRHI
{
namespace MTL
{
ShaderLibraryImpl::ShaderLibraryImpl(Device* device) : ShaderLibrary(device) {}

ShaderLibraryImpl::~ShaderLibraryImpl() = default;

void ShaderLibraryImpl::Create(std::span<std::byte> code)
{
  dispatch_data_t data = dispatch_data_create(
      code.data(),
      code.size(),
      dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0),
      DISPATCH_DATA_DESTRUCTOR_DEFAULT);

  auto device = ToBackend(m_Device)->GetNativeDevice();

  NSError* err = nil;
  m_Library = [device newLibraryWithData:data error:&err];
}
}  // namespace MTL
}  // namespace IssouRHI
