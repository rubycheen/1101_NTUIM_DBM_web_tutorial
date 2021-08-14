import { Select } from 'antd';
import 'antd/dist/antd.css';
import axios from 'axios';

const { Option } = Select;

const Stations = ({ setFrom, setTo, setCheck }) => {

    const stations = ['南港','臺北','桃園','新竹','臺中','彰化','雲林','嘉義','臺南','高雄','左營'] //打API

    axios.get('http://127.0.0.1:8000/api/stations')
      .then((res) => { console.log('stations',res.data) })
      .catch((error) => { console.log(error) })

    const onChange = (value) => {
        console.log(`selected ${value}`);
        setFrom ? setFrom(value) : setTo(value)
        setCheck(false)
      }
      
    const onSearch = (val) => {
        console.log('search:', val);
      }
      
      return(
        <Select
          showSearch
          style={{ width: 200 }}
          defaultValue={setFrom?"南港":"左營"}
          onChange={onChange}
          onSearch={onSearch}
          filterOption={(input, option) =>
            option.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
          }
        >
        {stations.map((station)=>{
            return <Option value={station}>{station}</Option>
        })}
        </Select>
      );

}



export default Stations