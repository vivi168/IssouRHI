#pragma once

#include "CommonMTL.h"

namespace IssouRHI
{
namespace MTL
{
class CommandBufferImpl : public CommandBuffer
{
public:
  CommandBufferImpl(Device* device);
  ~CommandBufferImpl() override;

  void Create() override;
  void Init() override;
  void Reset() override;

public:
  id<MTL4CommandBuffer> GetNativeCommandBuffer() const { return m_CommandBuffer; }

private:
  id<MTL4CommandAllocator> m_CommandAllocator;
  id<MTL4CommandBuffer> m_CommandBuffer;
};

inline CommandBufferImpl* ToBackend(CommandBuffer* cb) { return static_cast<CommandBufferImpl*>(cb); }

class QueueImpl : public Queue
{
public:
  QueueImpl(Device* device);
  ~QueueImpl() override;

  void Create() override;

  void Submit(std::span<CommandBuffer*> commandBuffers) override;
  void WaitForAll() override;

public:
  id<MTL4CommandQueue> GetNativeQueue() const { return m_CommandQueue; }

protected:
  std::unique_ptr<CommandEncoder> CreateCommandEncoderImpl(std::string label, CommandBuffer* commandBuffer) override;
  std::unique_ptr<CommandBuffer> CreateCommandBufferImpl() override;

  uint64_t FenceCompletedValue() const override { return [m_Fence signaledValue]; }

private:
  id<MTL4CommandQueue> m_CommandQueue;

  id<MTLSharedEvent> m_Fence;
  uint64_t m_NextFenceValue = 0;
};

inline QueueImpl* ToBackend(Queue* q) { return static_cast<QueueImpl*>(q); }
}  // namespace MTL
}  // namespace IssouRHI
