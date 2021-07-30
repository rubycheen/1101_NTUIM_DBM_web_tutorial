import { Table } from 'antd';

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
  
  /* 打API */
  const data = [
    {
      key: '1',
      type: '標準車廂',
      full: 1024,
      discount: 512,
      earlyBird: 800,
      undergraduate: 700,
      group: 822,
    },
    {
      key: '2',
      type: '商務車廂',
      full: 2048,
      discount: 1024,
      earlyBird: 900,
      undergraduate: 800,
      group: 933,
    },
    {
      key: '3',
      type: '自由座車廂',
      full: 909,
      discount: 455,
      earlyBird: 750,
      undergraduate: 750,
      group: 830,
    },
  ];

const Fare = () => {
    return <>
        <h2>車廂票價參考</h2>
        <Table columns={columns} dataSource={data} />
    </>
}

export default Fare