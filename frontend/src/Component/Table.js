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

let tabel = []

axios.post('http://127.0.0.1:8000/api/timetable/search', {
  "StartStation": "南港",
  "EndStation": "左營",
  "OutWardSearchDate": "2021/08/30",
  "OutWardSearchTime": "12:30"
})
.then((res) => { 
  tabel = res.data
})
.catch((error) => { console.log(error) })

const Tab = () => {
    return <Table columns={columns} dataSource={tabel} />
}

export default Tab