import React from 'react';
import { TimePicker } from 'antd';
import moment from 'moment';


const Time = ({ setTime, setCheck }) => {
    const  onChange = (time, timeString) => {
        console.log(time, timeString);
        setTime(timeString)
        setCheck(false)
      }

    return (
          
          <TimePicker format="HH:mm" onChange={onChange} defaultValue={moment('13:30', 'HH:mm')}/>
    );
}

export default Time