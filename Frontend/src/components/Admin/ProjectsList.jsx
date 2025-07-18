import { useEffect, useState } from "react";
import { getProjects } from "../../utils/api";
import ProjectsTable from "../Project/ProjectsTable";


export default function ProjectsList() {
  const [projects, setProjects] = useState([]);
  useEffect(() => {
    async function fetchProjects() {
      try {
        const projects = await getProjects();
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