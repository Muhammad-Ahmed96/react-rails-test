import { useContext, useRef, useState } from "react"
import { AuthContext } from "../../context/authContext";


export default function AssignProject({ project_id, assignProjectToUser }) {
  const { token } = useContext(AuthContext);
  const [users, setUsers] = useState([])
  const nameRef = useRef();

  const searchUser = async (value) => {
    const resp = await fetch(`http://localhost:3000/admin/users?search=${value}`, {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    })

    const data = await resp.json();
    console.log(data)
    setUsers(data);
  }

  const handleSelectUser = (projectId, userId) => {
    assignProjectToUser(projectId, userId)
    nameRef.current.value = ''
    setUsers([]);
  }

  return <form className="form-group">
    <label>Search User</label>
    <input type="search" ref={nameRef}  className="form-control" onChange={(event) => searchUser(event.target.value)} />
    <div className="list-group">
      {
        users.map(user => {
          return <div key={user.id} className="list-group-item pointer" onClick={() => handleSelectUser(project_id, user.id)}>{user.name}</div>
        })
      }
    </div>
  </form>
}