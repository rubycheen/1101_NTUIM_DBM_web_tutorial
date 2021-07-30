import { DatePicker } from 'antd';
import moment from 'moment';


const Date = ( { setDate, setCheck } ) => {

  const dateFormat = 'YYYY/MM/DD';

  const  onChange = (date, dateString) => {
    console.log(date, dateString);
    setDate(dateString)
    setCheck(false)
  }

  const disabledDate = (current) => {
    // Can not select days before today and today
    return current && current < moment().endOf('day');
  }
  
  return <DatePicker disabledDate={disabledDate} onChange={onChange} defaultValue={moment(moment().endOf('day'), dateFormat)} format={dateFormat}/>
}

export default Date