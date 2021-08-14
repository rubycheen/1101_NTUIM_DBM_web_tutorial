import { Table } from 'antd';
import axios from 'axios';
import { useState, useEffect } from 'react';

const Fare = ({ from, to, date }) => {

  const [fare, setFare] = useState([])

  useEffect(() => {
    axios.post('http://127.0.0.1:8000/api/ticket/search', {
      "StartStation": from,
      "EndStation": to,
      "OutWardSearchDate": date
    })
    .then((res) => { 
      setFare(res.data)
    })
    .catch((error) => { console.log(error) })
  },[])

  const columns = [
    {
        title: '',
        dataIndex: 'type',
        key: 'type',
      },
    {
        title: '全票',
        dataIndex: 'full',
        key: 'full',
      },
    {
      title: '優惠票',
      dataIndex: 'discount',
      key: 'discount',
    },
    {
      title: '早鳥票',
      dataIndex: 'earlyBird',
      key: 'earlyBird',
    },
    {
      title: '大學生優惠',
      key: 'undergraduate',
      dataIndex: 'undergraduate',
    },
    {
        title: '團體票',
        dataIndex: 'group',
        key: 'group',
      },
  ];


  return <>
      <h2>車廂票價參考</h2>
      <Table columns={columns} dataSource={fare} />
  </>
}

export default Fare