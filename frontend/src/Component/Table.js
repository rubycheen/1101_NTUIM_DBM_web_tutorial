import { Table } from 'antd';
import { CheckOutlined, CloseOutlined } from '@ant-design/icons';
import axios from 'axios';
import { useState, useEffect } from 'react';


const Tab = ({ from, to, date, time }) => {
  const [tabel, setTable] = useState([])

  useEffect(() => {
    axios.post('http://127.0.0.1:8000/api/timetable/search', {
      "StartStation": from,
      "EndStation": to,
      "OutWardSearchDate": date,
      "OutWardSearchTime": time
    })
    .then((res) => { 
      setTable(res.data)
    })
    .catch((error) => { console.log(error) })
  },[])

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
  
  
  return <Table columns={columns} dataSource={tabel} />
}

export default Tab