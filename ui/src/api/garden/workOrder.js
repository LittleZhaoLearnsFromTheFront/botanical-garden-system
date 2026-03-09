import request from '@/utils/request'

// 查询工单任务列表
export function listWorkOrder(query) {
  return request({
    url: '/garden/workOrder/list',
    method: 'get',
    params: query
  })
}

// 查询工单任务详细
export function getWorkOrder(workOrderId) {
  return request({
    url: '/garden/workOrder/' + workOrderId,
    method: 'get'
  })
}

// 新增工单任务
export function addWorkOrder(data) {
  return request({
    url: '/garden/workOrder',
    method: 'post',
    data: data
  })
}

// 修改工单任务
export function updateWorkOrder(data) {
  return request({
    url: '/garden/workOrder',
    method: 'put',
    data: data
  })
}

// 删除工单任务
export function delWorkOrder(workOrderId) {
  return request({
    url: '/garden/workOrder/' + workOrderId,
    method: 'delete'
  })
}

// 工单状态变更（接单/完成/取消）
export function changeWorkOrderStatus(data) {
  return request({
    url: '/garden/workOrder/status',
    method: 'put',
    data: data
  })
}

// 工单智能辅助（AI 建议/问答）
export function aiAssistWorkOrder(data) {
  return request({
    url: '/garden/workOrder/ai/assist',
    method: 'post',
    data: data,
    // AI 调用可能较慢，单独放宽超时时间
    timeout: 60000,
    // 由调用方自行处理错误提示，避免重复弹窗
    showErrorMessage: false
  })
}

