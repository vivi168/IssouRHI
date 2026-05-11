#include "PipelineMTL.h"

#include "DeviceMTL.h"
#include "ShaderLibraryMTL.h"
#include "UtilsMTL.h"

namespace IssouRHI
{
namespace MTL
{
ComputePipelineImpl::ComputePipelineImpl(Device* device) : ComputePipeline(device) {}

ComputePipelineImpl::~ComputePipelineImpl() = default;

static MTL4LibraryFunctionDescriptor* ToMTL4LibraryFunctionDescriptor(const ShaderModule& shader)
{
  assert(shader.entryPointName.has_value());

  MTL4LibraryFunctionDescriptor* desc = [[MTL4LibraryFunctionDescriptor alloc] init];

  desc.library = ToBackend(shader.library)->GetNativeLibrary();
  desc.name = [NSString stringWithUTF8String:shader.entryPointName.value().c_str()];

  return desc;
}

void ComputePipelineImpl::Create(const ComputePipelineDesc& desc)
{
  MTL4ComputePipelineDescriptor* psoDesc = [[MTL4ComputePipelineDescriptor alloc] init];
  psoDesc.label = [NSString stringWithUTF8String:desc.label.c_str()];
  psoDesc.computeFunctionDescriptor = ToMTL4LibraryFunctionDescriptor(desc.shader);

  auto compiler = ToBackend(m_Device)->Compiler();

  NSError* err = nil;
  m_Pso = [compiler newComputePipelineStateWithDescriptor:psoDesc
                                      compilerTaskOptions:nil
                                                    error:&err];
}

RenderPipelineImpl::RenderPipelineImpl(Device* device, Type type) : RenderPipeline(device, type) {}

RenderPipelineImpl::~RenderPipelineImpl() = default;

void RenderPipelineImpl::Create(const RenderPipelineDesc& desc)
{
  const auto fillPsoDesc = [&](auto& psoDesc) {
    psoDesc.label = [NSString stringWithUTF8String:desc.label.c_str()];

    // TODO: assert desc.targets.size() <= max color attachment
    for (size_t i = 0; i < desc.targets.size(); i++) {
      auto& target = desc.targets[i];
      psoDesc.colorAttachments[i].pixelFormat = ToMTLPixelFormat(target.format);
    }

    // TODO: fill everything
  };

  auto compiler = ToBackend(m_Device)->Compiler();

  switch (m_Type) {
    case Type::Render: {
      MTL4RenderPipelineDescriptor* psoDesc = [[MTL4RenderPipelineDescriptor alloc] init];
      fillPsoDesc(psoDesc);

      for (const auto& shader : desc.shaders) {
        if (shader.stage == ShaderStage::Fragment) {
          psoDesc.fragmentFunctionDescriptor = ToMTL4LibraryFunctionDescriptor(shader);
        } else if (shader.stage == ShaderStage::Vertex) {
          psoDesc.vertexFunctionDescriptor = ToMTL4LibraryFunctionDescriptor(shader);
        }
      }

      NSError* err = nil;
      m_Pso = [compiler newRenderPipelineStateWithDescriptor:psoDesc
                                         compilerTaskOptions:nil
                                                       error:&err];

      break;
    }
    case Type::Mesh: {
      // TODO
      break;
    }
    default:
      std::unreachable();
  }
}
}  // namespace MTL
}  // namespace IssouRHI
