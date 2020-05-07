import React, {} from 'react'
import {useParams} from 'react-router-dom'

export const WorksDetail: React.FC = () => {
  const { id } = useParams()
  return (
    <div>
      {id}
    </div>
  )
}

export default WorksDetail
