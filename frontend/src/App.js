import { useState } from 'react'
import MenuSet from './Container/MenuSet'
import Schedule from './Container/Schedule'


const App = () => {

    const [from, setFrom] = useState('南港')
    const [to, setTo] = useState('左營')
    let now = new Date()
    const [date, setDate] = useState(now.getFullYear()+'/'+(now.getMonth()+1)+'/'+now.getDate())
    console.log(date);
    const [time, setTime] = useState('13:30')
    const [check, setCheck] = useState(false)

    return <>
        <MenuSet setFrom={setFrom} setTo={setTo} setTime={setTime} setDate={setDate} setCheck={setCheck}/>
        {check?<Schedule from={from} to={to} date={date} time={time}/>:<></>}
    </>

}

export default App
