import request from '@/utils/request'

// 查询纪念品列表
export function listSouvenir(query) {
  return request({
    url: '/garden/souvenir/list',
    method: 'get',
    params: query
  })
}

// 查询纪念品详细
export function getSouvenir(souvenirId) {
  return request({
    url: '/garden/souvenir/' + souvenirId,
    method: 'get'
  })
}

// 新增纪念品
export function addSouvenir(data) {
  return request({
    url: '/garden/souvenir',
    method: 'post',
    data: data
  })
}

// 修改纪念品（包含库存修改）
export function updateSouvenir(data) {
  return request({
    url: '/garden/souvenir',
    method: 'put',
    data: data
  })
}

// 删除纪念品
export function delSouvenir(souvenirId) {
  return request({
    url: '/garden/souvenir/' + souvenirId,
    method: 'delete'
  })
}

