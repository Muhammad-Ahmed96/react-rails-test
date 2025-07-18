import { useContext, useEffect, useState } from "react";
import Project from "./Project";
import { getAssignedProjects, getProjects } from "../../utils/api";
import ProjectsTable from "./ProjectsTable";
import { AuthContext } from "../../context/authContext";


export default function ProjectsList() {
  const [projects, setProjects] = useState([]);
  const { user } = useContext(AuthContext);
  useEffect(() => {
    async function fetchProjects() {
      try {
        const projects = await getAssignedProjects();
        setProjects(projects)
      }catch(error) {
        console.log(error)
      }
    } 
    fetchProjects();
  }, [])

  console.log(projects)

  if(projects.length === 0 ){
    return <p>No Project Found!!!</p>
  }
  return <>
    <ProjectsTable projects={projects} />
  </>
}