import { Table } from 'antd';
import axios from 'axios';

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

  let fare = []

  axios.post('http://127.0.0.1:8000/api/ticket/search', {
    "StartStation": "南港",
    "EndStation": "左營",
    "OutWardSearchDate": "2021/08/30"
  })
  .then((res) => { 
    fare = res.data
  })
  .catch((error) => { console.log(error) })

const Fare = () => {
    return <>
        <h2>車廂票價參考</h2>
        <Table columns={columns} dataSource={fare} />
    </>
}

export default Fare