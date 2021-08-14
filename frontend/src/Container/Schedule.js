import Table from '../Component/Table'
import ScheduleHeader from '../Component/ScheduleHeader';
import Fare from '../Component/Fare';


const Schedule = ({ from, to, date, time }) => {

    return(
        <div className='schedule'>
            <ScheduleHeader from={from} to={to} date={date} time={time} />
            <Table from={from} to={to} date={date} time={time}/>
            <Fare from={from} to={to} date={date}/>
        </div>
    )
}

export default Schedule