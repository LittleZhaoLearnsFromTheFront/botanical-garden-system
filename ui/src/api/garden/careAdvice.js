import request from '@/utils/request'

// 查询养护建议列表
export function listCareAdvice(query) {
  return request({
    url: '/garden/careAdvice/list',
    method: 'get',
    params: query
  })
}

// 查询养护建议详情
export function getCareAdvice(adviceId) {
  return request({
    url: '/garden/careAdvice/' + adviceId,
    method: 'get'
  })
}

// 查询最新已通过建议
export function getLatestCareAdvice(query) {
  return request({
    url: '/garden/careAdvice/latest',
    method: 'get',
    params: query
  })
}

// 生成建议
export function generateCareAdvice(data) {
  return request({
    url: '/garden/careAdvice/generate',
    method: 'post',
    data,
    // AI 生成可能较慢，放宽超时时间
    timeout: 180000,
    showErrorMessage: false
  })
}

// 审核
export function reviewCareAdvice(data) {
  return request({
    url: '/garden/careAdvice/review',
    method: 'post',
    data
  })
}

// 一键转工单
export function careAdviceToWorkOrder(data) {
  return request({
    url: '/garden/careAdvice/toWorkOrder',
    method: 'post',
    data
  })
}
