import { Table } from 'antd';
import { CheckOutlined, CloseOutlined } from '@ant-design/icons';
import axios from 'axios';


const columns = [
  {
    title: '出發時間',
    dataIndex: 'startTime',
    key: 'name',
  },
  {
    title: '行車時間',
    dataIndex: 'timeSpend',
    key: 'timeSpend',
  },
  {
    title: '抵達時間',
    dataIndex: 'arrivalTime',
    key: 'arrivalTime',
  },
  {
    title: '車次',
    key: 'number',
    dataIndex: 'number',
  },
  {
    title: '是否適用早鳥',
    key: 'earlyBird',
    dataIndex: 'earlyBird',
    render: earlyBird => (
      <>
        {earlyBird ? <CheckOutlined />:<CloseOutlined />}
      </>
    ),
  },
  {
    title: '是否適用大學生優惠',
    key: 'undergraduate',
    dataIndex: 'undergraduate',
    render: undergraduate => (
      <>
        {undergraduate ? <CheckOutlined />:<CloseOutlined />}
      </>
    ),
  },
];

/* 打API */

const data = [
  {
    key: '1',
    startTime: '20:00',
    timeSpend: 32,
    arrivalTime: '20:32',
    number: 522,
    earlyBird: true,
    undergraduate: false
  },
  {
    key: '2',
    startTime: '20:10',
    timeSpend: 42,
    arrivalTime: '20:52',
    number: 833,
    earlyBird: true,
    undergraduate: true
  },
  {
    key: '3',
    startTime: '20:20',
    timeSpend: 32,
    arrivalTime: '20:52',
    number: 333,
    earlyBird: false,
    undergraduate: true
  },
];

axios.post('http://127.0.0.1:8000/timetable/search', {
  "StartStation": "南港",
  "EndStation": "左營",
  "OutWardSearchDate": "2021/08/12",
  "OutWardSearchTime": "12:30"
})
.then((res) => { console.log('table',res.data) })
.catch((error) => { console.log(error) })

const Tab = () => {
    return <Table columns={columns} dataSource={data} />
}

export default Tab