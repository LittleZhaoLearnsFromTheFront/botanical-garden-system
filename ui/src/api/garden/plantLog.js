import request from '@/utils/request'

// 查询植物维护日志列表
export function listPlantLog(query) {
  return request({
    url: '/garden/plantLog/list',
    method: 'get',
    params: query
  })
}

