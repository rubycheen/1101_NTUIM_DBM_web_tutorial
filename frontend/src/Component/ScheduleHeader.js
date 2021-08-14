import { Space } from 'antd'
import { DoubleRightOutlined } from '@ant-design/icons';


const ScheduleHeader = ({ from, to, date, time }) => {
    return(
        <div className='schedule'>
            <Space className='schedule-header'>
                <h1>{from}</h1>
                <DoubleRightOutlined style={{ fontSize: '25px'}}/>
                <h1>{to}</h1>
                <h3>{date}</h3>
                <h3>{time}</h3>
            </Space>
        </div>
    )
}

export default ScheduleHeader