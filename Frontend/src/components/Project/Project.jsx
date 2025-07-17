import { Navigate, useNavigate } from "react-router-dom"


export default function Project({id, name, start_date, duration}) {
  const navigate = useNavigate()
  function showProject(id) {
    navigate(`/projects/${id}`)
  }

  return <tr>
    <td>{name}</td>
    <td>{start_date}</td>
    <td>{duration}</td>
    <td><button className="btn btn-sm btn-primary" onClick={() => showProject(id)}>View</button></td>
  </tr>
}