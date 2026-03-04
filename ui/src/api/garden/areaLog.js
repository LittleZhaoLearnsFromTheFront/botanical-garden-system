import request from '@/utils/request'

// 查询区域维护日志列表
export function listAreaLog(query) {
  return request({
    url: '/garden/areaLog/list',
    method: 'get',
    params: query
  })
}

