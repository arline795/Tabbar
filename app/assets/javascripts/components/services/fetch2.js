export function fetch2(url, options= {}) {
  const csrfMeta = document.getElementsByName('csrf-token')[0];
  const headers = {
    'Content-Type': 'application/json',
    'X-CSRF-TOKEN': csrfMeta ? csrfMeta.content : '',
    'X-auth-token': options.auth_token
  };

  options = {
    credentials: 'same-origin',
    redirect: 'error',
    headers: headers,
    ...options
  };

  if(options.queryParams) {
    url += (url.indexOf('?') === -1 ? '?' : '&') + queryParams(options.queryParams);
    delete options.queryParams;
  }

  return window.fetch(url, options);
}

function queryParams(params) {
  return Object.keys(params)
      .map(k => encodeURIComponent(k) + '=' + encodeURIComponent(params[k]))
      .join('&');
}
