import request from '@/utils/request'

// 查询娱乐设备列表
export function listDevice(query) {
  return request({
    url: '/garden/device/list',
    method: 'get',
    params: query
  })
}

// 查询娱乐设备详细
export function getDevice(deviceId) {
  return request({
    url: '/garden/device/' + deviceId,
    method: 'get'
  })
}

// 新增娱乐设备
export function addDevice(data) {
  return request({
    url: '/garden/device',
    method: 'post',
    data: data
  })
}

// 修改娱乐设备
export function updateDevice(data) {
  return request({
    url: '/garden/device',
    method: 'put',
    data: data
  })
}

// 删除娱乐设备
export function delDevice(deviceId) {
  return request({
    url: '/garden/device/' + deviceId,
    method: 'delete'
  })
}

