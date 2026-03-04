import request from '@/utils/request'

// 查询设备维护日志列表
export function listDeviceLog(query) {
  return request({
    url: '/garden/deviceLog/list',
    method: 'get',
    params: query
  })
}

