#pragma once

#include "CommonD3D12.h"

#include <string>
#include <string_view>
#include <vector>

namespace IssouRHI
{
namespace D3D12
{
std::wstring StringToWstring(std::string_view s);
void ReportLiveObjects();
void PrintAdapterList();
void PrintStateObjectDesc(const D3D12_STATE_OBJECT_DESC* desc);

inline DXGI_FORMAT DXGIFormat(TextureFormat format)
{
  switch (format) {
    case TextureFormat::Undefined:
      return DXGI_FORMAT_UNKNOWN;
    case TextureFormat::BC5Unorm:
      return DXGI_FORMAT_BC5_UNORM;
    case TextureFormat::BC7Unorm:
      return DXGI_FORMAT_BC7_UNORM;
    case TextureFormat::Depth32Float:
      return DXGI_FORMAT_D32_FLOAT;
    case TextureFormat::R8Unorm:
      return DXGI_FORMAT_R8_UNORM;
    case TextureFormat::R16Unorm:
      return DXGI_FORMAT_R16_UNORM;
    case TextureFormat::RG8Unorm:
      return DXGI_FORMAT_R8G8_UNORM;
    case TextureFormat::R32Uint:
      return DXGI_FORMAT_R32_UINT;
    case TextureFormat::R32Float:
      return DXGI_FORMAT_R32_FLOAT;
    case TextureFormat::RGBA8Unorm:
      return DXGI_FORMAT_R8G8B8A8_UNORM;
    case TextureFormat::RGBA8Uint:
      return DXGI_FORMAT_R8G8B8A8_UINT;
    case TextureFormat::RGB10A2Unorm:
      return DXGI_FORMAT_R10G10B10A2_UNORM;
    case TextureFormat::RG32Float:
      return DXGI_FORMAT_R32G32_FLOAT;
    case TextureFormat::RGBA16Float:
      return DXGI_FORMAT_R16G16B16A16_FLOAT;
    case TextureFormat::RGBA32Float:
      return DXGI_FORMAT_R32G32B32A32_FLOAT;
    default:
      std::unreachable();  // TODO: add missing formats
  }
}

inline DXGI_FORMAT DXGIFormat(VertexFormat format)
{
  switch (format) {
    case VertexFormat::Undefined:
      return DXGI_FORMAT_UNKNOWN;
    case VertexFormat::Float32x3:
      return DXGI_FORMAT_R32G32B32_FLOAT;
    default:
      std::unreachable();
  }
}

inline DXGI_FORMAT DXGIFormat(IndexFormat format)
{
  switch (format) {
    case IndexFormat::Undefined:
      return DXGI_FORMAT_UNKNOWN;
    case IndexFormat::Uint16:
      return DXGI_FORMAT_R16_UINT;
    case IndexFormat::Uint32:
      return DXGI_FORMAT_R32_UINT;
    default:
      std::unreachable();
  }
}

std::vector<D3D12_RAYTRACING_GEOMETRY_DESC> D3D12RaytracingGeometryDescs(std::span<BottomLevelGeometryDesc> geometries);

inline D3D12_COMPARISON_FUNC D3D12ComparisonFunc(CompareFunction function)
{
  switch (function) {
    case CompareFunction::Never:
      return D3D12_COMPARISON_FUNC_NEVER;
    case CompareFunction::Less:
      return D3D12_COMPARISON_FUNC_LESS;
    case CompareFunction::Equal:
      return D3D12_COMPARISON_FUNC_EQUAL;
    case CompareFunction::LessEqual:
      return D3D12_COMPARISON_FUNC_LESS_EQUAL;
    case CompareFunction::Greater:
      return D3D12_COMPARISON_FUNC_GREATER;
    case CompareFunction::NotEqual:
      return D3D12_COMPARISON_FUNC_NOT_EQUAL;
    case CompareFunction::GreaterEqual:
      return D3D12_COMPARISON_FUNC_GREATER_EQUAL;
    case CompareFunction::Always:
      return D3D12_COMPARISON_FUNC_ALWAYS;
    default:
      std::unreachable();
  }
}
}  // namespace D3D12
}  // namespace IssouRHI
