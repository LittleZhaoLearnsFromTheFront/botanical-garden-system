import request from '@/utils/request'

/** 基础数据统计（区域、植物、设备、纪念品数量） */
export function getBasicStatistics() {
  return request({
    url: '/garden/statistics/basic',
    method: 'get',
    showErrorMessage: false
  })
}

/** 任务数据统计（工单按状态分布） */
export function getTaskStatistics() {
  return request({
    url: '/garden/statistics/task',
    method: 'get',
    showErrorMessage: false
  })
}
