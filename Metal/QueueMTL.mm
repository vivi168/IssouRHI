#include "QueueMTL.h"

#include "CommandEncoderMTL.h"
#include "DeviceMTL.h"
#include "UtilsMTL.h"

namespace IssouRHI
{
namespace MTL
{
CommandBufferImpl::CommandBufferImpl(Device* device) : CommandBuffer(device) {}

CommandBufferImpl::~CommandBufferImpl() = default;

void CommandBufferImpl::Create()
{
  auto device = ToBackend(m_Device)->GetNativeDevice();

  m_CommandAllocator = [device newCommandAllocator];

  m_CommandBuffer = [device newCommandBuffer];

  Init();
}

void CommandBufferImpl::Init()
{
  [m_CommandBuffer beginCommandBufferWithAllocator:m_CommandAllocator];
}

void CommandBufferImpl::Reset()
{
  [m_CommandAllocator reset];
}

QueueImpl::QueueImpl(Device* device) : Queue(device) {}

QueueImpl::~QueueImpl()
{
  WaitForAll();
}

void QueueImpl::Create()
{
  auto device = ToBackend(m_Device)->GetNativeDevice();

  m_CommandQueue = [device newMTL4CommandQueue];

  m_Fence = [device newSharedEvent];
}

void QueueImpl::Submit(std::span<CommandBuffer*> commandBuffers)
{
  @autoreleasepool {
    m_NextFenceValue++;

    std::vector<id<MTL4CommandBuffer>> cmdBufs;

    for (auto cb : commandBuffers) {
      cb->UpdateFenceValue(m_NextFenceValue);
      m_CommandBuffersExecuting.push_back(cb);
      cmdBufs.push_back(ToBackend(cb)->GetNativeCommandBuffer());
    }

    if (!cmdBufs.empty()) {
      [m_CommandQueue commit:cmdBufs.data() count:cmdBufs.size()];
    }

    [m_CommandQueue signalEvent:m_Fence value:m_NextFenceValue];

    RecycleCommandBuffers();
  }
}

void QueueImpl::WaitForAll()
{
  const uint64_t fenceValue = m_NextFenceValue++;
  [m_CommandQueue signalEvent:m_Fence value:fenceValue];

  if ([m_Fence signaledValue] < fenceValue) {
    [m_Fence waitUntilSignaledValue:fenceValue timeoutMS:UINT64_MAX];
  }
}

std::unique_ptr<CommandEncoder> QueueImpl::CreateCommandEncoderImpl(std::string label, CommandBuffer* commandBuffer)
{
  return std::make_unique<CommandEncoderImpl>(label, commandBuffer);
}

std::unique_ptr<CommandBuffer> QueueImpl::CreateCommandBufferImpl()
{
  return std::make_unique<CommandBufferImpl>(m_Device);
}
}  // namespace MTL
}  // namespace IssouRHI
