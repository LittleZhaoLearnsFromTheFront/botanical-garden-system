import request from '@/utils/request'

// 查询植物档案列表
export function listPlant(query) {
  return request({
    url: '/garden/plant/list',
    method: 'get',
    params: query
  })
}

// 查询植物档案详细
export function getPlant(plantId) {
  return request({
    url: '/garden/plant/' + plantId,
    method: 'get'
  })
}

// 新增植物档案
export function addPlant(data) {
  return request({
    url: '/garden/plant',
    method: 'post',
    data: data
  })
}

// 修改植物档案
export function updatePlant(data) {
  return request({
    url: '/garden/plant',
    method: 'put',
    data: data
  })
}

// 删除植物档案
export function delPlant(plantId) {
  return request({
    url: '/garden/plant/' + plantId,
    method: 'delete'
  })
}

