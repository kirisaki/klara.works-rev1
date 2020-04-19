const wrapper = <T>(task: Promise<Response>): Promise<T> => {
  return new Promise((resolve, reject) => {
    task
      .then(response => {
        if (response.ok) {
          response
            .json()
            .then(json => {
              resolve(json)
            })
            .catch(error => {
              reject(error)
            })
        } else {
          reject(response)
        }
      })
      .catch(error => {
        reject(error)
      })
  })
}

export const req = <T = any>(input: RequestInfo, init?: RequestInit): Promise<T> => {
  return wrapper<T>(fetch(input, init))
}
