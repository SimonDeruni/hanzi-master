const fs = require('fs');
const path = require('path');

const locations = {};

function add(name, type, province, city, lat, lng, englishNames, dialect, context) {
  locations[name] = { name, type, province: province || null, city: city || null, lat, lng, englishNames: englishNames || [], dialect: dialect || null, context: context || null };
}


add('北京', 'city', '北京', '北京', 39.9042, 116.4074, ['Beijing', 'Peking'], 'mandarin');
add('上海', 'city', '上海', '上海', 31.2304, 121.4737, ['Shanghai'], 'shanghainese');
add('天津', 'city', '天津', '天津', 39.3434, 117.3616, ['Tianjin'], 'mandarin');
add('重庆', 'city', '重庆', '重庆', 29.4316, 106.9123, ['Chongqing'], 'sichuanese');
add('广州', 'city', '广东', '广州', 23.1291, 113.2644, ['Guangzhou','Canton'], 'cantonese');
add('深圳', 'city', '广东', '深圳', 22.5431, 114.0579, ['Shenzhen'], 'cantonese');
add('成都', 'city', '四川', '成都', 30.5728, 104.0668, ['Chengdu'], 'sichuanese');
add('杭州', 'city', '浙江', '杭州', 30.2741, 120.1551, ['Hangzhou'], 'wu');
add('苏州', 'city', '江苏', '苏州', 31.2990, 120.5853, ['Suzhou'], 'wu');
add('南京', 'city', '江苏', '南京', 32.0603, 118.7969, ['Nanjing'], 'mandarin');
add('西安', 'city', '陕西', '西安', 34.3416, 108.9398, ["Xi'an","Xian"], 'mandarin');
add('武汉', 'city', '湖北', '武汉', 30.5928, 114.3055, ['Wuhan'], 'mandarin');
add('昆明', 'city', '云南', '昆明', 25.0389, 102.7183, ['Kunming'], 'mandarin');
add('哈尔滨', 'city', '黑龙江', '哈尔滨', 45.8038, 126.5350, ['Harbin'], 'mandarin');
add('拉萨', 'city', '西藏', '拉萨', 29.6500, 91.1000, ['Lhasa'], 'tibetan');
add('青岛', 'city', '山东', '青岛', 36.0671, 120.3826, ['Qingdao'], 'mandarin');
add('厦门', 'city', '福建', '厦门', 24.4798, 118.0894, ['Xiamen','Amoy'], 'minnan');
add('长沙', 'city', '湖南', '长沙', 28.2282, 112.9388, ['Changsha'], 'xiang');
add('郑州', 'city', '河南', '郑州', 34.7466, 113.6254, ['Zhengzhou'], 'mandarin');
add('桂林', 'city', '广西', '桂林', 25.2736, 110.2900, ['Guilin'], 'mandarin');
add('香港', 'city', '香港', '香港', 22.3193, 114.1694, ['Hong Kong'], 'cantonese');
add('澳门', 'city', '澳门', '澳门', 22.1987, 113.5439, ['Macau','Macao'], 'cantonese');
add('济南', 'city', '山东', '济南', 36.6512, 117.1201, ['Jinan'], 'mandarin');
add('太原', 'city', '山西', '太原', 37.8706, 112.5489, ['Taiyuan'], 'mandarin');
add('沈阳', 'city', '辽宁', '沈阳', 41.8057, 123.4315, ['Shenyang'], 'mandarin');
add('大连', 'city', '辽宁', '大连', 38.9140, 121.6147, ['Dalian'], 'mandarin');
add('长春', 'city', '吉林', '长春', 43.8171, 125.3235, ['Changchun'], 'mandarin');
add('合肥', 'city', '安徽', '合肥', 31.8206, 117.2272, ['Hefei'], 'mandarin');
add('福州', 'city', '福建', '福州', 26.0745, 119.2965, ['Fuzhou'], 'mindong');
add('南昌', 'city', '江西', '南昌', 28.6820, 115.8579, ['Nanchang'], 'gan');
add('贵阳', 'city', '贵州', '贵阳', 26.6470, 106.6302, ['Guiyang'], 'mandarin');
add('兰州', 'city', '甘肃', '兰州', 36.0611, 103.8343, ['Lanzhou'], 'mandarin');
add('西宁', 'city', '青海', '西宁', 36.6171, 101.7785, ['Xining'], 'mandarin');
add('银川', 'city', '宁夏', '银川', 38.4872, 106.2309, ['Yinchuan'], 'mandarin');
add('海口', 'city', '海南', '海口', 20.0440, 110.3500, ['Haikou'], 'hainanese');
add('三亚', 'city', '海南', '三亚', 18.2528, 109.5120, ['Sanya'], 'hainanese');
add('南宁', 'city', '广西', '南宁', 22.8170, 108.3665, ['Nanning'], 'cantonese');
add('洛阳', 'city', '河南', '洛阳', 34.6197, 112.4539, ['Luoyang'], 'mandarin');
add('大理', 'city', '云南', '大理', 25.6065, 100.2676, ['Dali'], 'bai');
add('丽江', 'city', '云南', '丽江', 26.8721, 100.2299, ['Lijiang'], 'naxi');
add('敦煌', 'city', '甘肃', '敦煌', 40.1410, 94.6619, ['Dunhuang'], 'mandarin');
add('台北', 'city', '台湾', '台北', 25.0330, 121.5654, ['Taipei'], 'minnan');